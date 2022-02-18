### This app was built on python 3.7.3
from flask import Flask,render_template,request,jsonify
from sklearn.externals import joblib
from sklearn.preprocessing import StandardScaler
from flask.logging import create_logger
import json
import logging
import pandas as pd
 
app = Flask(__name__)
LOG = create_logger(app)
LOG.setLevel(logging.INFO)

def scale(payload):
    """Scales Payload"""
    
    LOG.info(f"Scaling Payload: \n{payload}")
    scaler = StandardScaler().fit(payload.astype(float))
    scaled_adhoc_predict = scaler.transform(payload.astype(float))
    if
    return scaled_adhoc_predict
 
@app.route('/form')
def form():
    return render_template('inputform.html')
 
@app.route('/predict', methods = ['POST'])
@app.route('/data/', methods = ['POST', 'GET'])
def data():
    if request.method == 'GET':
        return f"The URL /data is accessed directly. Try going to '/form' to submit form"
    if request.method == 'POST':
        form_data = request.form
        # print("payload: ",form_data.get('param1'))
        payload = {  
                "CHAS":{  
                    "0":form_data.get('param1')
                },
                "RM":{  
                    "0":form_data.get('param2')
                },
                "TAX":{  
                    "0":form_data.get('param3')
                },
                "PTRATIO":{  
                    "0":form_data.get('param4')
                },
                "B":{  
                    "0":form_data.get('param5')
                },
                "LSTAT":{  
                    "0":form_data.get('param6')
                }
            }
        # json_payload = json.dumps(payload)
        # print("json payload hard-code: ",payload)

        # Logging the input payload
        json_payload = request.json
        # print("json payload: ",json_payload)
        LOG.info(f"JSON payload: \n{json_payload}")
        inference_payload = pd.DataFrame(payload)
        LOG.info(f"Inference payload DataFrame: \n{inference_payload}")
        # scale the input
        scaled_payload = scale(inference_payload)
        # get an output prediction from the pretrained model, clf
        prediction = list(clf.predict(scaled_payload))
        # print("Prediction: ",prediction)
        # TO DO:  Log the output prediction value
        LOG.info(f"Prediction output DataFrame: \n{prediction}")
        # return jsonify({'prediction': prediction})

        return render_template('data.html',form_data = [{'prediction':prediction}])
 
if __name__ == "__main__":
    # load pretrained model as clf
    clf = joblib.load("./model_data/boston_housing_prediction.joblib")
    # app.run(host='localhost', port=5000, debug=True) # specify port=80
    app.run(host='0.0.0.0', port=80)
