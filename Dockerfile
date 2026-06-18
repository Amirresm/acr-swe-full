# for building auto-code-rover:latest
FROM yuntongzhang/swe-bench:latest

RUN git config --global user.email acr-arise@nus.edu.sg
RUN git config --global user.name acr-arise

ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y vim build-essential libssl-dev

COPY auto-code-rover/environment.yml /opt/auto-code-rover/environment.yml
COPY auto-code-rover/requirements*.txt /opt/auto-code-rover/

WORKDIR /opt/auto-code-rover
RUN conda env create -f environment.yml

# for arise
RUN wget -qO- https://astral.sh/uv/install.sh | sh

COPY ARISE/pyproject.toml /opt/arise/pyproject.toml

WORKDIR /opt/arise
# RUN uv sync

COPY auto-code-rover /opt/auto-code-rover

COPY ARISE /opt/arise

# Utils
COPY acr-swe-full/assets/banner.sh /etc/profile.d/banner.sh
RUN echo 'source /etc/profile.d/banner.sh' >> /etc/bash.bashrc

COPY acr-swe-full/assets /opt/assets
COPY acr-swe-full/conf /opt/conf

COPY acr-swe-full/scripts/setup-testbed.sh /opt/SWE-bench
COPY acr-swe-full/scripts/run-eval.sh /opt/SWE-bench

COPY acr-swe-full/scripts/run-acr.sh /opt/auto-code-rover

WORKDIR /opt

ENTRYPOINT [ "/bin/bash" ]

