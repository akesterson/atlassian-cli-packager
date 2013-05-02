%define __os_install_post %{nil}
Summary: atlassian-cli
Name: atlassian-cli
Version: %{version}
Release: %{release}
License: Atlassian EULA Standard License
Vendor: Bob Swift Software, LLC
Packager: Andrew Kesterson <andrew@aklabs.net>
Group: Application/Development
Provides: %{name}
Requires: java
BuildArch: x86_64
BuildRoot: %{_tmppath}/%{name}-%{version}-%{release}
Source: %{name}-%{version}-%{release}.tar.gz


%description
Atlassian CLI tools by Bob Swift. See https://marketplace.atlassian.com/plugins/org.swift.atlassian.cli
 
%install
mkdir -p %{buildroot}/opt/atlassian-cli
tar -zxvf %{_sourcedir}/%{name}-%{version}-%{release}.tar.gz -C %{buildroot}/opt/atlassian-cli
 
%files
/opt/atlassian-cli
