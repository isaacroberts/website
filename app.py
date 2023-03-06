from flask import Flask
from flask import render_template
from flask import request
from flask import send_from_directory


from flask_cors import CORS


import os
import datetime

# Flask setup
app = Flask(__name__)
CORS(app, resources={r"*": {"origins": "*"}})
FLUTTER_WEB_APP = 'templates'

# Email
RECVR = 'isaaclevinroberts@gmail.com'
SENDR = 'algorithmicdesignmusic@gmail.com'
PSWRD = 'dbcvyphjrtuytsev'

# creates SMTP session
import smtplib
from email.message import EmailMessage
mailer = smtplib.SMTP('smtp.gmail.com', 587)
mailer.starttls()
mailer.login(SENDR, PSWRD)

print('CWD:')
print(os.getcwd())
print("Files:")
files = os.listdir('.')
print(files)

@app.route('/')
def render_page():
    return render_template('index.html')


@app.route('/web/')
def render_page_web():
    return render_template('index.html')

@app.route('/web/<path:name>')
def return_flutter_doc(name):

    datalist = str(name).split('/')
    DIR_NAME = FLUTTER_WEB_APP

    if len(datalist) > 1:
        for i in range(0, len(datalist) - 1):
            DIR_NAME += '/' + datalist[i]

    return send_from_directory(DIR_NAME, datalist[-1])

@app.route('/contact', methods=['GET', 'POST'])
def submit_contact():
    if request.method=='POST':
        try:
            data= request.get_json()
            address=data['email']
            body=data['body'] if 'body' in data.keys() else '[error: no body]'
        except Exception as e:
            print('Excpetion')
            print(e)
            return '',500
    else:
        address = request.args.get('email')
        body = request.args.get('body')
    # print ('isP1:',isP1)

    if address is None:
        # print('Sent none values')
        return 'No values sent',400

    if body=='':
        body='[err: empty body]'

    print('Email:', address, 'Body:', body)

    currentDT = datetime.datetime.now()

    msg = f"""
New contact: {address}


Body:
    {body}



Sent at: {str(currentDT)}
    """

    message = EmailMessage()
    message['Subject'] = 'New Contact' # Subject of Email
    message['From'] = SENDR
    message['To'] = RECVR # Reciver of the Mail
    message.set_content(msg) # Email body or Content


    # sending the mail
    mailer.send_message(message)

    # TODO: Save data to make sure i don't lose email addresses


    return {'sweet':'thanks'}


if __name__ == '__main__':
    app.debug = False
    app.run()
