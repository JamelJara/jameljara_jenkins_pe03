FROM python:3.9.16-bullseye
COPY requirements.txt ./requirements.txt
RUN pip install -r requirements.txt
COPY flask_app.py ./flask_app.py
RUN mkdir docker-ml-model
ENV MODEL_DIR=docker-ml-model
ENV MODEL_FILE_LDA=clf_lda.joblib
ENV MODEL_FILE_NN=clf_nn.joblib
RUN pip install joblib
COPY train.csv ./train.csv
COPY test.csv ./test.csv
COPY train.py ./train.py
COPY inference.py ./inference.py
RUN python3 train.py
# configure the container to run in an executed manner
ENTRYPOINT [ "python" ]
CMD ["flask_app.py" ]