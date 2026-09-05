# syntax=docker/dockerfile:1
FROM debian:trixie-slim

ARG USERNAME=dev
ARG USER_UID=1000
ARG USER_GID=1000

ENV DEBIAN_FRONTEND=noninteractive \
    LANG=C.UTF-8 \
    SHELL=/bin/bash

RUN apt-get update \
 && apt-get install -y --no-install-recommends ca-certificates curl git sudo \
 && rm -rf /var/lib/apt/lists/* \
 && groupadd --gid "$USER_GID" "$USERNAME" \
 && useradd --uid "$USER_UID" --gid "$USER_GID" --create-home --shell /bin/bash "$USERNAME" \
 && echo "$USERNAME ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/"$USERNAME" \
 && chmod 0440 /etc/sudoers.d/"$USERNAME"

USER $USERNAME
WORKDIR /home/$USERNAME

# The source state is bind-mounted rather than COPYed so it never lands in a
# layer: --one-shot purges it, but a COPY layer would keep it in the image.
RUN --mount=type=bind,source=.,target=/tmp/dotfiles,ro \
    mkdir -p ~/.local/share \
 && cp -a /tmp/dotfiles ~/.local/share/chezmoi \
 && sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --one-shot --promptDefaults \
 && sudo rm -rf /var/lib/apt/lists/* \
 && rm -rf ~/.cache

ENV PATH=/home/$USERNAME/.local/share/mise/shims:/home/$USERNAME/.local/bin:$PATH

CMD ["sleep", "infinity"]
