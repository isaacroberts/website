from flask import Flask
from flask import render_template
from flask import request
from flask import send_from_directory


from flask_cors import CORS


import os


# template_dir = os.path.abspath('./web/')
# template_dir = 'web/'
app = Flask(__name__)
# app = Flask(__name__, template_folder='web/')
CORS(app, resources={r"*": {"origins": "*"}})


FLUTTER_WEB_APP = 'flutter'


@app.route('/')
def render_page():
    return render_template('index.html')


@app.route('/web/')
def render_page_web():
    return render_template('index.html')



# @app.route('/dev')
# def dev_index():
#     if uploading:
#         return render_template('dev_uploading_page.html')
#     else:
#         return  render_template('dev/index.html')



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
    print('contact')
    print(request.method)

    if request.method=='POST':
        try:
            data= request.get_json()
            print(data)
            address=data['email']
            body=data['body'] if 'body' in data else ''
        except Exception as e:
            print('Excpetion')
            print(e)
            return '',500
    else:
        address = request.args.get('email')
        body = request.args.get('body')
    # print ('isP1:',isP1)

    if address is None:
        print('Sent none values')
        return 'No values sent',400
    print('got email:', address, body)
    # print('response:', resp)
    return {'yeahyeah':'gotit'}


if __name__ == '__main__':
    # print('running');
    app.debug = True
    app.run() #go to http://localhost:5000/ to view the page.
    # app.run(ssl_context=('cert.pem', 'key.pem')) #go to http://localhost:5000/ to view the page.
