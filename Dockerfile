FROM python:3.10.12

WORKDIR /Devopsela

COPY . /Devopsela

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 5000

CMD ["python", "./app.py"]
