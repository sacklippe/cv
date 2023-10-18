# Use an image with TeX Live preinstalled
FROM aergus/latex:latest

# Set working directory in the container
WORKDIR /usr/src/mylatex

# Copy the LaTeX files into the container
COPY . .

# Run the make command when the container starts
CMD ["make"]

