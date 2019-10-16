# We need IIS
FROM mcr.microsoft.com/windows/servercore/iis:windowsservercore-1903

# We're going to do our IIS Administration with Powershell
SHELL ["powershell", "-Command"]

RUN New-Item -Path C:\Chat -ItemType Directory

# Support ASP Classic
RUN Install-WindowsFeature Web-ASP; 
RUN Install-WindowsFeature Web-ISAPI-Ext;

# Support Static Content
RUN Install-WindowsFeature Web-Static-Content;

# Remove the Default Web Site
RUN Remove-Website -Name 'Default Web Site';

# Create a new web site
RUN New-IISSite -Name "chat" \
                -PhysicalPath "c:\chat" \
                -BindingInformation "*:80:";

# Copy the files into the container
COPY chat/*.* /chat/