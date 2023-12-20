# Dit project maakt gebruik van:
- Vue3
- ViteJS
- Tailwindcss
- PostCSS
- Prettier
- Axios
- Typescript (niet actief gebruik van gemaakt)
- Docker


## json-server
json-server is aangepast. Aangezien ik niet de CORS werkend kreeg via docker,
heb ik de server van json-server geextend. Vanuit hier kon ik de CORS uitschakelen
voor development. Dus deze runt nu een custom `server.js` file.

```sh
docker-compose up
```

## Project Setup

```sh
npm install
```

### Compile and Hot-Reload for Development

```sh
npm run dev
```