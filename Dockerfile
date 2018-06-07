FROM microsoft/dotnet:2.1.300-sdk-alpine3.7 AS build
WORKDIR /app

# Copy csproj and restore as distinct layers
COPY *.csproj ./
RUN dotnet restore

# Copy everything else and build
COPY . ./
RUN dotnet publish -c Release -r linux-musl-x64 -o out /p:ShowLinkerSizeComparison=true

# Build runtime image
FROM microsoft/dotnet:2.1.0-runtime-deps-alpine3.7 AS runtime
WORKDIR /app
COPY --from=build /app/out .
ENV ASPNETCORE_URLS=http://+:80
EXPOSE 80
ENTRYPOINT ["./dotnetcore-dockerised"]