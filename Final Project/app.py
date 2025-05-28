from flask import Flask, render_template, request, redirect, url_for, session, flash
import mysql.connector
from werkzeug.security import generate_password_hash, check_password_hash
import functools

app = Flask(__name__)
app.secret_key = 'your_secret_key_here'  # Change to a strong secret key

# Database connection
def get_db_connection():
    conn = mysql.connector.connect(
        host="localhost",
        user="root",
        password="",
        database="macminimart"
    )
    return conn

# Login required decorator to check if the user is logged in
def login_required(view):
    @functools.wraps(view)
    def wrapped_view(**kwargs):
        if 'user_id' not in session:  # Check if 'user_id' exists in session (user is logged in)
            print("User not logged in, redirecting to login page...")  # Debugging line
            return redirect(url_for('login'))  # Redirect to login if user is not logged in
        return view(**kwargs)
    return wrapped_view

# Register Route
@app.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        username = request.form['username'].strip()
        password = request.form['password']
        conn = get_db_connection()
        cursor = conn.cursor()

        # Check if username already exists
        cursor.execute("SELECT id FROM users WHERE username = %s", (username,))
        existing_user = cursor.fetchone()

        if existing_user:
            flash('Username already exists! Choose a different one.')
            cursor.close()
            conn.close()
            return redirect(url_for('register'))

        # Hash the password and insert into the database
        hashed_password = generate_password_hash(password)
        cursor.execute("INSERT INTO users (username, password) VALUES (%s, %s)",
                       (username, hashed_password))
        conn.commit()
        cursor.close()
        conn.close()
        flash('Registration successful! Please login.')
        return redirect(url_for('login'))

    return render_template('register.html')

# Login Route
@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username'].strip()
        password = request.form['password']

        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT id, password FROM users WHERE username = %s", (username,))
        user = cursor.fetchone()
        cursor.close()
        conn.close()

        if user and check_password_hash(user[1], password):
            # Set session information
            session.clear()  # Clear previous session (important for security)
            session['user_id'] = user[0]  # Set the user ID in the session
            session['username'] = username  # Set the username in the session
            print(f"User {username} logged in, session: {session}")  # Debugging line
            flash('Login successful!')
            return redirect(url_for('index'))  # Redirect to index page after login
        else:
            flash('Invalid username or password.')
            print(f"Failed login attempt for username: {username}")  # Debugging line
            return redirect(url_for('login'))  # Stay on login page if invalid credentials

    return render_template('login.html')

# Logout Route
@app.route('/logout')
def logout():
    session.clear()  # Clear the session to log out
    flash('You have been logged out.')
    return redirect(url_for('login'))  # Redirect to login page after logout

# Index Route (Home Page)
@app.route('/')
@login_required
def index():
    print(f"Session at index route: {session}")  # Debugging line to show session data
    return render_template('index.html')

# Products Route (Show products available)
@app.route('/products')
@login_required
def products():
    print(f"Session at products route: {session}")  # Debugging line
    try:
        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT id, name, type, price FROM products ORDER BY id")
        products_list = cursor.fetchall()
        cursor.close()
        conn.close()
        return render_template('products.html', products=products_list)
    except mysql.connector.Error as err:
        return f"Database error: {err}", 500

# Buy Route (Handle product purchase)
@app.route('/buy', methods=['POST'])
@login_required
def buy():
    selected = request.form.getlist('product_ids')
    user_id = session.get('user_id')
    if selected and user_id:
        conn = get_db_connection()
        cursor = conn.cursor()
        # Insert transaction linked to logged-in user
        cursor.execute("INSERT INTO transactions (user_id) VALUES (%s)", (user_id,))
        conn.commit()
        transaction_id = cursor.lastrowid
        for pid in selected:
            cursor.execute("INSERT INTO transaction_items (transaction_id, product_id) VALUES (%s, %s)", (transaction_id, pid))
        conn.commit()
        cursor.close()
        conn.close()
        return redirect(url_for('receipt', transaction_id=transaction_id))
    return redirect(url_for('products'))

# Receipt Route (Show receipt after purchase)
@app.route('/receipt/<int:transaction_id>')
@login_required
def receipt(transaction_id):
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("""
        SELECT p.name, p.type, p.price, t.transaction_time
        FROM transaction_items ti
        JOIN products p ON ti.product_id = p.id
        JOIN transactions t ON ti.transaction_id = t.id
        WHERE ti.transaction_id = %s
    """, (transaction_id,))
    rows = cursor.fetchall()
    total = sum(row[2] for row in rows) if rows else 0
    cursor.close()
    conn.close()
    return render_template('receipt.html', items=rows, total=total)

# Transactions Route (Show user's transactions)
@app.route('/transactions')
@login_required
def transactions():
    print(f"Session at transactions route: {session}")  # Debugging line
    user_id = session.get('user_id')
    try:
        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute("""
            SELECT 
                t.id, 
                t.transaction_time, 
                p.name, 
                p.price
            FROM transaction_items ti
            JOIN transactions t ON ti.transaction_id = t.id
            JOIN products p ON ti.product_id = p.id
            WHERE t.user_id = %s
            ORDER BY t.transaction_time DESC, t.id DESC
        """, (user_id,))
        transactions_list = cursor.fetchall()
        cursor.close()
        conn.close()
        return render_template('transactions.html', transactions=transactions_list)
    except mysql.connector.Error as err:
        return f"Database error: {err}", 500

if __name__ == '__main__':
    app.run(debug=True)
