#!/bin/bash

# Install npm packages
echo "Installing npm packages..."
npm i

# Create Python virtual environment
echo "Creating Python virtual environment..."
curl https://bootstrap.pypa.io/get-pip.py --output get-pip.py
python3 get-pip.py
python3 -m venv venv

# Install Python packages using pip
echo "Installing Python dependencies..."
source ./venv/bin/activate
pip3 install --upgrade pip
pip3 install -r requirements.txt

# Prisma Migrations
echo "Applying Prisma Migrations..."
npx prisma generate
npx prisma migrate deploy

# Building the project
echo "Building the project..."
npm run build

# Building is finished
echo "Building is finished"
#pause