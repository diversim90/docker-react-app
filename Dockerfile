# builder stage
FROM node:alpine as builder
WORKDIR '/usr/src/app'
COPY package.json .
RUN npm install
COPY ./ ./
RUN npm run build

# run stage
FROM nginx
#EXPOSE 80

# --from : 다른 stage에 있는 파일을 복사할 때 
#          해당 stage 이름을 명시

# /usr/src/app/build
# builder stage에서 생성된 파일들이 저장되는 폴더임.

# /usr/share/nginx/html
# /usr/src/app/build 에 저장된 파일들을 복사하는 폴더를 지정.
# Nginx 가 가동후에 정적파일을 참조하게되는 폴더임.

COPY --from=builder /usr/src/app/build /usr/share/nginx/html
