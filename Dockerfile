FROM jupyter/scipy-notebook:latest

COPY requirements.txt /

RUN pip install -r /requirements.txt

USER root
RUN apt-get update && apt-get upgrade -y
