# nova.conf
[DEFAULT]
debug = {{.Values.debug}}

log_config_append = /etc/nova/logging.ini
state_path = /var/lib/nova

use_neutron = True
linuxnet_interface_driver = nova.network.linux_net.LinuxOVSInterfaceDriver

# we patched this to be treated as force_resize_to_same_host
# https://github.com/sapcc/nova/commit/fd9508038351d027dcbf94282ba83caed5864a97
allow_resize_to_same_host = true

enable_new_services={{ .Values.enable_new_services | default .Release.IsInstall }}

osapi_compute_link_prefix=https://{{include "nova_api_endpoint_host_public" .}}:{{.Values.global.novaApiPortPublic}}
osapi_compute_workers=8
metadata_workers=8

memcache_servers =  {{include "memcached_host" .}}:{{.Values.global.memcached_port_public | default "11211" }}

default_schedule_zone = {{.Values.global.default_availability_zone}}
default_availability_zone = {{.Values.global.default_availability_zone}}

rpc_response_timeout = {{ .Values.rpc_response_timeout | default .Values.global.rpc_response_timeout | default 60 }}
rpc_workers = {{ .Values.rpc_workers | default .Values.global.rpc_workers | default 1 }}

wsgi_default_pool_size = {{ .Values.wsgi_default_pool_size | default .Values.global.wsgi_default_pool_size | default 100 }}

transport_url = {{include "oslo_messaging_rabbit_url" .}}

{{ template "utils.snippets.debug.eventlet_backdoor_ini" "nova" }}

[api_database]
connection = {{ tuple . .Values.apidbName .Values.apidbUser .Values.apidbPassword | include "db_url" }}

{{ include "ini_sections.database" . }}

# most default quotas are 0 to enforce usage of the Resource Management tool in Elektra
quota_cores = 0
quota_instances = 0
quota_ram = 0

quota_fixed_ips = 0
quota_floating_ips = 0
quota_networks = 0
quota_security_group_rules = 0
quota_security_groups = 0

# usage refreshes on new reservations, 0 means disabled
# number of seconds between subsequent usage refreshes
max_age = {{ .Values.usage_max_age | default 0 }}
# count of reservations until usage is refreshed
until_refresh = {{ .Values.usage_until_refresh | default 0 }}

{{- include "osprofiler" . }}

[conductor]
workers=8

[spice]
enabled = True
html5proxy_base_url = https://{{include "nova_console_endpoint_host_public" .}}:{{.Values.global.novaConsolePortPublic}}/spicehtml5/spice_auto.html

[vnc]
enabled = True
vncserver_listen = $my_ip
vncserver_proxyclient_address = $my_ip
novncproxy_base_url = https://{{include "nova_console_endpoint_host_public" .}}:{{ .Values.global.novaConsolePortPublic }}/novnc/vnc_auto.html?path=/novnc/websockify
novncproxy_host = 0.0.0.0
novncproxy_port = {{ .Values.consoles.novnc.portInternal }}

[serial_console]
enabled = True
base_url = https://{{include "nova_console_endpoint_host_public" .}}:{{ .Values.global.novaConsolePortPublic }}/serial

[shellinabox]
host = 0.0.0.0
port = {{ .Values.consoles.shellinabox.portInternal }}
base_url = https://{{include "nova_console_endpoint_host_public" .}}:{{ .Values.global.novaConsolePortPublic }}/shellinabox
proxyclient_url = https://{{include "ironic_console_endpoint_host_public" .}}

{{ include "oslo_messaging_rabbit" .}}

[oslo_concurrency]
lock_path = /var/lib/nova/tmp

[glance]
api_servers = http://{{include "glance_api_endpoint_host_internal" .}}:{{.Values.global.glance_api_port_internal | default "9292" }}/v2
num_retries = 10

[cinder]
os_region_name = {{.Values.global.region}}
catalog_info = volumev2:cinderv2:internalURL
cross_az_attach={{.Values.cross_az_attach}}

[neutron]
url = http://{{include "neutron_api_endpoint_host_internal" .}}:{{ .Values.global.neutron_api_port_internal | default "9696" }}
metadata_proxy_shared_secret = {{ .Values.global.nova_metadata_secret }}
service_metadata_proxy = true
auth_url = http://{{include "keystone_api_endpoint_host_internal" .}}:{{ .Values.global.keystone_api_port_internal | default "5000" }}/v3
auth_plugin = v3password
username = {{ .Values.global.neutron_service_user | default "neutron" }}{{ .Values.global.user_suffix }}
password = {{ .Values.global.neutron_service_password | default (tuple . .Values.global.neutron_service_user | include "identity.password_for_user") | replace "$" "$$" }}
user_domain_name = {{.Values.global.keystone_service_domain | default "Default" }}
region_name = {{.Values.global.region}}
project_name = {{.Values.global.keystone_service_project | default "service" }}
project_domain_name = {{.Values.global.keystone_service_domain | default "Default" }}

[keystone_authtoken]
auth_plugin = v3password
auth_version = v3
www_authenticate_uri = https://{{include "keystone_api_endpoint_host_public" .}}/v3
auth_url = {{.Values.global.keystone_api_endpoint_protocol_internal | default "http"}}://{{include "keystone_api_endpoint_host_internal" .}}:{{ .Values.global.keystone_api_port_internal | default 5000}}/v3
username = {{ .Values.global.nova_service_user | default "nova" }}{{ .Values.global.user_suffix }}
password = {{ .Values.global.nova_service_password | default (tuple . .Values.global.nova_service_user | include "identity.password_for_user") | replace "$" "$$" }}
user_domain_name = "{{.Values.global.keystone_service_domain | default "Default" }}"
project_name = "{{.Values.global.keystone_service_project | default "service" }}"
project_domain_name = "{{.Values.global.keystone_service_domain | default "Default" }}"
memcached_servers = {{ .Chart.Name }}-memcached.{{ include "svc_fqdn" . }}:{{ .Values.memcached.memcached.port | default 11211 }}
insecure = True

#[upgrade_levels]
#compute = auto

[oslo_messaging_notifications]
driver = noop

[oslo_middleware]
enable_proxy_headers_parsing = true

{{- if .Values.placement.enabled }}
[placement]
auth_type = password
auth_url = http://{{include "keystone_api_endpoint_host_internal" .}}:{{ .Values.global.keystone_api_port_internal | default "5000" }}/v3
username = {{.Values.global.placement_service_user}}
password = {{ .Values.global.placement_service_password | default (tuple . .Values.global.placement_service_user | include "identity.password_for_user") | replace "$" "$$" }}
user_domain_name = "{{.Values.global.keystone_service_domain | default "Default" }}"
project_name = service
project_domain_name = "{{.Values.global.keystone_service_domain | default "Default" }}"
os_interface = internal
os_region_name = {{.Values.global.region}}
region_name = {{.Values.global.region}}
{{- end }}

{{- include "ini_sections.audit_middleware_notifications" . }}

{{- include "ini_sections.cache" . }}
