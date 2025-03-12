# Use the official .NET SDK image to build the application
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the project file(s) and restore any dependencies (via dotnet restore)
COPY *.csproj ./
RUN dotnet restore

# Copy the rest of the application code and build it
COPY . ./
RUN dotnet publish -c Release -o out

# Use the official .NET runtime image to run the application
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS runtime

# Set the working directory for the runtime image
WORKDIR /app

# Copy the built application from the build image
COPY --from=build /app/out .

# Define the entry point for the container
ENTRYPOINT ["dotnet", "TodoAPI.dll"]

# Expose port for the application to run
EXPOSE 80
