# Use the official .NET SDK image to build the application
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the solution file to the container
COPY TodoAPI.sln ./

# Copy the project file to the container
COPY TodoAPI/TodoAPI.csproj ./TodoAPI/

# Restore dependencies (uses the solution file)
RUN dotnet restore TodoAPI.sln

# Copy the rest of the application code
COPY . ./

# Publish the application
RUN dotnet publish TodoAPI/TodoAPI.csproj -c Release -o out

# Use the official .NET runtime image to run the application
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime

# Set the working directory for the runtime image
WORKDIR /app

# Copy the published application from the build image
COPY --from=build /app/out .

# Define the entry point for the container
ENTRYPOINT ["dotnet", "TodoAPI.dll"]

# Expose port 80 so that the app can be accessed outside the container
EXPOSE 5080
    