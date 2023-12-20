FROM node:14-alpine

#Had to disable this one because it adds it globally,
#RUN yarn global add json-server
RUN yarn add json-server
COPY db.json db.json
COPY server.js server.js

EXPOSE 5000
CMD [ "node", "server" ]
#(--no-cors) didnt work, so i extended the server and created my own file to disable cors -> server.js
#CMD [ "json-server", "--host=0.0.0.0", "--port=5000", "--no-cors", "db.json" ]