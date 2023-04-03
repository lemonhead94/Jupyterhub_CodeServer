FROM jupyterhub/jupyterhub:latest

USER root

ENV CODE_VERSION=4.11.0
RUN ARCH=$(arch | sed s/aarch64/arm64/ | sed s/x86_64/amd64/) \
    && curl -fOL https://github.com/coder/code-server/releases/download/v$CODE_VERSION/code-server_${CODE_VERSION}_${ARCH}.deb \
    && dpkg -i code-server_${CODE_VERSION}_${ARCH}.deb \
    && curl -sL https://upload.wikimedia.org/wikipedia/commons/9/9a/Visual_Studio_Code_1.35_icon.svg -o /opt/vscode.svg \
    && rm -f code-server_${CODE_VERSION}_${ARCH}.deb

RUN pip install \
    oauthenticator \
    dockerspawner \
    jupyterhub-nativeauthenticator \
    jupyter-server-proxy \
    jupyter-vscode-proxy

USER ${NB_USER}

COPY jupyterhub_config.py /srv/jupyterhub/jupyterhub_config.py