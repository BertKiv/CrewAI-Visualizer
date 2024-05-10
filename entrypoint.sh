#!/bin/bash

# Prisma Migrations
echo "Applying Prisma Migrations..."
npx prisma generate
npx prisma migrate deploy

# Building the project
echo "Building the project..."
npm run build

# Building is finished
echo "Building is finished"
npm run start