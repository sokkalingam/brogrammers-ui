FROM vuejs/ci:latest

WORKDIR /brogrammers-ui

COPY src                    /brogrammers-ui/src
COPY public                 /brogrammers-ui/public
COPY package.json           /brogrammers-ui
COPY package-lock.json      /brogrammers-ui

RUN npm install

EXPOSE 3000

ENTRYPOINT [ "npm", "run", "serve", "--", "--port", "3000"]