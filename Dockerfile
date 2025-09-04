FROM node:20-alpine

# Tạo thư mục app
WORKDIR /usr/src/nuxt-app

# Copy package.json trước để tận dụng cache layer
COPY package.json yarn.lock ./

# Cài dependencies
RUN yarn install --frozen-lockfile

# Copy toàn bộ source code
COPY . .

# Biến môi trường cho Nuxt
ENV NUXT_HOST=0.0.0.0
ENV NUXT_PORT=3000

ARG API_URL
ENV API_URL=${API_URL}

# Build app
RUN yarn build

# Expose port
EXPOSE 3000

# Start app
CMD ["yarn", "start"]
