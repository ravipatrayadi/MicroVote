# Use a specific platform for building the image based on the build environment
FROM --platform=${BUILDPLATFORM} mcr.microsoft.com/dotnet/sdk:7.0 AS build

# Define build-time arguments for target platform, architecture, and build platform
ARG TARGETPLATFORM
ARG TARGETARCH
ARG BUILDPLATFORM

# Print a message to verify which platform and architecture are being used for the build
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"

# Set the working directory inside the container to /source
WORKDIR /source

# Copy the .csproj file(s) from the local context to the container's working directory
COPY *.csproj .

# Restore the dependencies specified in the .csproj file(s) for the specified architecture
RUN dotnet restore -a $TARGETARCH

# Copy the entire project files to the container's working directory
COPY . .

# Publish the project as a release build to the /app directory, specifying the architecture
RUN dotnet publish -c release -o /app -a $TARGETARCH --self-contained false --no-restore

# Start a new stage using a smaller runtime image to run the application
FROM mcr.microsoft.com/dotnet/runtime:7.0

# Set the working directory inside the container to /app
WORKDIR /app

# Copy the published application files from the build stage to the runtime stage
COPY --from=build /app .

# Define the entry point for the container to run the application
ENTRYPOINT ["dotnet", "worker.dll"]
