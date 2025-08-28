# Start from Amazon Linux 2 (CodeBuild compatible base)
FROM public.ecr.aws/amazonlinux/amazonlinux:2

# Install updates and basic tools
RUN yum update -y && yum install -y     gcc     git     tar     gzip     zip     unzip     make     wget     curl     yum-utils     && yum clean all

# Install Node.js (example: 18.x)
RUN curl -sL https://rpm.nodesource.com/setup_18.x | bash -     && yum install -y nodejs     && yum clean all

# Install Python (example: 3.11)
RUN amazon-linux-extras enable python3.11     && yum install -y python3.11 python3.11-pip     && alternatives --install /usr/bin/python3 python3 /usr/bin/python3.11 2     && pip3 install --upgrade pip

# (Optional) Install Java
RUN amazon-linux-extras enable corretto17     && yum install -y java-17-amazon-corretto-devel

# Set environment variables for CodeBuild
ENV PATH=$PATH:/usr/local/bin
ENV CODEBUILD_BUILD_IMAGE=custom

# Default working directory
WORKDIR /app

# Entrypoint (CodeBuild overrides this with buildspec.yml)
CMD ["bash"]
