FROM python:3.10-slim

RUN apt-get update && apt-get install -y \
    build-essential \
    libxml2-dev \
    libxslt1-dev \
    libldap2-dev \
    libsasl2-dev \
    libpq-dev \
    libjpeg-dev \
    libpng-dev \
    libffi-dev \
    libssl-dev \
    wkhtmltopdf \
    git \
    curl \
    && apt-get clean

RUN useradd -m -d /opt/odoo -U -r -s /bin/bash odoo

WORKDIR /opt/odoo

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD ["python3", "odoo-bin", "-c", "/etc/odoo/odoo.conf"]
