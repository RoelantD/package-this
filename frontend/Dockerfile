FROM node:20-alpine AS builder
ARG AZURE_MAPS_KEY=""
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN sed -i "s|azureMapsKey: ''|azureMapsKey: '${AZURE_MAPS_KEY}'|" src/environments/environment.prod.ts
RUN npm run build

FROM nginx:alpine
COPY --from=builder /app/dist/dm-package-manager/browser /usr/share/nginx/html
# nginx.conf is a template; the entrypoint runs envsubst on ${BACKEND_URL}.
# Default targets the docker-compose backend service; overridden in Azure.
ENV BACKEND_URL=http://backend:8000
COPY nginx.conf /etc/nginx/templates/default.conf.template
EXPOSE 4200
CMD ["nginx", "-g", "daemon off;"]
