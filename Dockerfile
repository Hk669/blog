FROM python:3.9

WORKDIR /app

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .
EXPOSE 8000

CMD [ "mkdocs", "serve", "-a", "0.0.0.0:8000" ]