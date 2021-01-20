FROM mcr.microsoft.com/powershell:7.1.1-ubuntu-18.04

COPY entrypoint.ps1 /entrypoint.ps1
RUN chmod +x /entrypoint.ps1

ENTRYPOINT ["/entrypoint.ps1"]