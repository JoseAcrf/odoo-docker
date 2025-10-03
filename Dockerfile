FROM python:3.10-slim

# Evitar prompts interactivos
ENV DEBIAN_FRONTEND=noninteractive

# Instalar dependencias del sistema
RUN apt-get update && apt-get install -y \
    build-essential \
    libxml2-dev \
    libxslt1-dev \
    zlib1g-dev \
    libsasl2-dev \
    libldap2-dev \
    libssl-dev \
    libffi-dev \
    libjpeg-dev \
    libpng-dev \
    liblcms2-dev \
    libblas-dev \
    libatlas-base-dev \
    libpq-dev \
    xfonts-75dpi \
    xfonts-base \
    libxrender1 \
    libxext6 \
    libfontconfig1 \
    curl \
    git \
    nodejs \
    npm \
    && apt-get clean

# Instalar LESS para frontend
RUN npm install -g less less-plugin-clean-css

# Instalar wkhtmltopdf desde paquete oficial
RUN curl -L -o wkhtmltox.deb https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.6/wkhtmltox_0.12.6-1.buster_amd64.deb \
    && apt-get install -y ./wkhtmltox.deb \
    && rm wkhtmltox.deb

# Crear usuario odoo
RUN useradd -m -d /opt/odoo -U -r -s /bin/bash odoo

# Directorio de trabajo
WORKDIR /opt/odoo

# Instalar dependencias Python
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copiar código fuente
COPY . .

# Comando por defecto
CMD ["python3", "odoo-bin", "-c", "/etc/odoo/odoo.conf"]
