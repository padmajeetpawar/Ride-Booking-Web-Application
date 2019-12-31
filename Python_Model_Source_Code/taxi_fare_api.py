import gzip
import joblib
import numpy as np
from flask import Flask, request, jsonify, render_template
from flask_cors import CORS, cross_origin

app = Flask(__name__)
CORS(app)
model = joblib.load(gzip.GzipFile('model' + '.lzma', 'rb'))

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/predict',methods=['POST'])
def predict():
    '''
    For rendering results on HTML GUI
    '''
    features = [float(x) for x in request.form.values()]
    final_features = [np.array(features)]
    prediction = model.predict(final_features)

    output = round(prediction[0], 2)

    return render_template('index.html', prediction_text='Taxi Fare $ {}'.format(output))

@app.route('/predict_api',methods=['POST'])
@cross_origin(origin='*')
def predict_api():
    '''
    For direct API calls trought request
    '''
    resp = None
    data = request.get_json(force=True)
    prediction = model.predict([np.array(list(data.values()))])
    print(data)

    output = prediction[0]
    resp = jsonify({"fare":output})
    resp.headers.add('Access-Control-Allow-Origin', '*')
    return resp
    #return jsonify({"fare": 0})

if __name__ == "__main__":
    app.run(debug=True)