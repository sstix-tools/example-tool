Name:           example-tool
Version:        %{version}
Release:        1%{?dist}
Summary:        Small example utility
License:        MIT
BuildArch:      noarch
Requires:       jq

%description
A small shell utility that stores state under XDG data directories.

%install
install -D -m 0755 %{_sourcedir}/example-tool %{buildroot}%{_bindir}/example-tool
install -D -m 0644 %{_sourcedir}/_example-tool \
    %{buildroot}%{_datadir}/zsh/site-functions/_example-tool

%files
%{_bindir}/example-tool
%{_datadir}/zsh/site-functions/_example-tool