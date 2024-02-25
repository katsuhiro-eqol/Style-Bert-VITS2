# Pythonのベースイメージを使用
FROM python:3.11-slim

# Git LFSのインストール
RUN apt-get update && \
    apt-get install -y git-lfs && \
    git lfs install

# リポジトリをクローン
RUN git clone https://github.com/litagin02/Style-Bert-VITS2.git

COPY ./.env /Style-Bert-VITS2/.env
WORKDIR /Style-Bert-VITS2
RUN pip install -r requirements.txt
RUN pip install google-cloud-storage
RUN python initialize.py --skip_jvnv

RUN mkdir -p /Style-Bert-VITS2/audioFiles

COPY ./api_server.py /Style-Bert-VITS2/api_server.py
CMD ["python", "-u", "/Style-Bert-VITS2/api_server.py"]
