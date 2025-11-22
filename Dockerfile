# Stage 1: Build the template package
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /template

# Copy all template files
COPY . .

# Create the NuGet package
RUN dotnet pack -o /output

# Stage 2: Validate the template
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS validate
WORKDIR /validation

# Copy the built package
COPY --from=build /output/*.nupkg /validation/

# Install the template
RUN dotnet new install /validation/ConsoleWithTests.Template.1.0.0.nupkg

# Create a test project using the template
RUN dotnet new console-with-tests -n Demo --Framework net8.0

# Navigate to the created project
WORKDIR /validation/Demo

# Build the solution
RUN dotnet build

# Run the tests
RUN dotnet test --no-build --verbosity normal

# Run the console app
RUN dotnet run --project src/App/App.csproj --no-build

# Stage 3: Final output
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS final
WORKDIR /output

# Copy the package for distribution
COPY --from=build /output/*.nupkg /output/

# Create a success indicator
RUN echo "✅ Template package built and validated successfully!" > /output/SUCCESS.txt && \
    echo "Package location: /output/ConsoleWithTests.Template.1.0.0.nupkg" >> /output/SUCCESS.txt && \
    echo "" >> /output/SUCCESS.txt && \
    echo "To use this template:" >> /output/SUCCESS.txt && \
    echo "1. Copy the .nupkg file from the container" >> /output/SUCCESS.txt && \
    echo "2. Install: dotnet new install ConsoleWithTests.Template.1.0.0.nupkg" >> /output/SUCCESS.txt && \
    echo "3. Create project: dotnet new console-with-tests -n MyProject" >> /output/SUCCESS.txt

# Display success message
CMD ["cat", "/output/SUCCESS.txt"]