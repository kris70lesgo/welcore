FROM dart:3.13.5
WORKDIR /app
COPY pubspec.yaml pubspec.lock ./
RUN dart pub get --enforce-lockfile
COPY bin ./bin
COPY lib ./lib
COPY config/production.yaml ./config/production.yaml
COPY migrations ./migrations
COPY web/app ./web/app
EXPOSE 8080
CMD ["dart", "run", "bin/main.dart", "--mode", "production", "--apply-migrations"]
