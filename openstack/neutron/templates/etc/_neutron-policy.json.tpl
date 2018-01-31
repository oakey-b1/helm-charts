{
    "context_is_cloud_admin":  "role:cloud_network_admin",
    "context_is_admin":  "rule:context_is_cloud_admin",
    "owner": "tenant_id:%(tenant_id)s",
    "member": "role:member and rule:owner",
    "viewer": "role:network_viewer and rule:owner",
    "admin": "role:network_admin and rule:owner",
    "context_is_network_admin": "rule:context_is_admin or rule:admin",
    "context_is_editor": "rule:context_is_network_admin or rule:member",
    "context_is_viewer":  "rule:context_is_editor or rule:viewer",
    "network_view_all": "role:network_viewer or role:member or role:network_admin or rule:context_is_admin",

    "network_owner": "tenant_id:%(network:tenant_id)s",
    "network_owner_or_owner": "rule:network_owner or rule:owner",
    "network_member": "role:member and rule:network_owner_or_owner",
    "network_viewer": "role:network_viewer and rule:network_owner_or_owner",
    "network_admin": "role:network_admin and rule:network_owner_or_owner",
    "context_is_network_network_admin": "rule:context_is_admin or rule:network_admin",
    "context_is_network_editor": "rule:context_is_network_network_admin or rule:network_member",
    "context_is_network_viewer":  "rule:context_is_network_editor or rule:network_viewer",

    "compute_admin": "role:compute_admin and rule:owner",
    "context_is_compute_admin": "role:cloud_compute_admin or rule:compute_admin",

    "shared": "field:networks:shared=True",
    "shared_firewalls": "field:firewalls:shared=True",
    "shared_firewall_policies": "field:firewall_policies:shared=True",
    "shared_subnetpools": "field:subnetpools:shared=True",
    "shared_address_scopes": "field:address_scopes:shared=True",
    "dhcp_enabled": "field:subnets:enable_dhcp=True",
    "default": "rule:context_is_editor or rule:shared",
    "default_viewer": "rule:context_is_viewer or rule:shared",
    "default_network_viewer": "rule:context_is_network_viewer or rule:shared",

    "create_subnet": "rule:context_is_admin or (rule:network_admin and rule:network_owner and rule:dhcp_enabled)",
    "create_subnet:segment_id": "rule:context_is_admin",
    "get_subnet": "rule:default_viewer",
    "get_subnet:segment_id": "rule:default_viewer",
    "update_subnet": "rule:context_is_network_admin",
    "delete_subnet": "rule:context_is_network_admin",

    "create_subnetpool": "rule:context_is_network_admin",
    "create_subnetpool:shared": "rule:context_is_admin",
    "create_subnetpool:is_default": "rule:context_is_admin",
    "get_subnetpool": "rule:context_is_viewer or rule:shared_subnetpools",
    "update_subnetpool": "rule:context_is_network_admin",
    "update_subnetpool:is_default": "rule:context_is_admin",
    "delete_subnetpool": "rule:context_is_network_admin",

    "create_address_scope": "rule:context_is_network_admin",
    "create_address_scope:shared": "rule:context_is_admin",
    "get_address_scope": "rule:context_is_editor or rule:shared_address_scopes",
    "update_address_scope": "rule:context_is_network_admin",
    "update_address_scope:shared": "rule:context_is_admin",
    "delete_address_scope": "rule:context_is_network_admin",

    "create_network": "rule:context_is_network_admin",
    "get_network": "rule:default_viewer",
    "get_network:router:external": "rule:default_viewer",
    "get_network:segments": "rule:default_viewer",
    "get_network:provider:network_type": "rule:default_viewer",
    "get_network:provider:physical_network": "rule:default_viewer",
    "get_network:provider:segmentation_id": "rule:default_viewer",
    "get_network:queue_id": "rule:context_is_admin",
    "get_network_ip_availabilities": "rule:default_network_viewer",
    "get_network_ip_availability": "rule:default_network_viewer",
    "create_network:shared": "rule:context_is_admin",
    "create_network:router:external": "rule:context_is_admin",
    "create_network:is_default": "rule:context_is_admin",
    "create_network:segments": "rule:context_is_admin",
    "create_network:provider:network_type": "rule:context_is_admin",
    "create_network:provider:physical_network": "rule:context_is_admin",
    "create_network:provider:segmentation_id": "rule:context_is_admin",
    "update_network": "rule:context_is_network_admin",
    "update_network:segments": "rule:context_is_admin",
    "update_network:shared": "rule:context_is_admin",
    "update_network:provider:network_type": "rule:context_is_admin",
    "update_network:provider:physical_network": "rule:context_is_admin",
    "update_network:provider:segmentation_id": "rule:context_is_admin",
    "update_network:router:external": "rule:context_is_admin",
    "delete_network": "rule:context_is_network_admin",

    "create_segment": "rule:context_is_admin",
    "get_segment": "rule:context_is_admin",
    "update_segment": "rule:context_is_admin",
    "delete_segment": "rule:context_is_admin",

    "network_device": "field:port:device_owner=~^network:",
    "create_port": "rule:default",
    "create_port:device_owner": "not rule:network_device or rule:context_is_network_editor",
    "create_port:mac_address": "rule:context_is_network_editor",
    "create_port:fixed_ips": "rule:default",
    "create_port:port_security_enabled": "rule:context_is_network_editor",
    "create_port:binding:host_id": "rule:context_is_network_admin",
    "create_port:binding:profile": "rule:context_is_network_admin",
    "create_port:binding:vnic_type": "rule:context_is_network_admin",
    "create_port:mac_learning_enabled": "rule:context_is_network_editor",
    "create_port:allowed_address_pairs": "rule:context_is_network_editor",
    "get_port": "rule:context_is_network_viewer",
    "get_port:queue_id": "rule:context_is_admin",
    "get_port:binding:vif_type": "rule:context_is_network_viewer",
    "get_port:binding:vif_details": "rule:context_is_network_viewer",
    "get_port:binding:host_id": "rule:context_is_network_viewer",
    "get_port:binding:profile": "rule:context_is_network_viewer",
    "get_port:binding:vnic_type": "rule:context_is_network_viewer",
    "update_port": "rule:context_is_editor",
    "update_port:device_owner": "not rule:network_device or rule:context_is_network_editor",
    "update_port:mac_address": "rule:context_is_admin",
    "update_port:fixed_ips": "rule:context_is_editor",
    "update_port:port_security_enabled": "rule:context_is_network_editor",
    "update_port:binding:host_id": "rule:context_is_network_admin",
    "update_port:binding:profile": "rule:context_is_network_admin",
    "update_port:binding:vnic_type": "rule:context_is_network_admin",
    "update_port:mac_learning_enabled": "rule:context_is_network_editor",
    "update_port:allowed_address_pairs": "rule:context_is_network_editor",
    "delete_port": "rule:context_is_network_editor",

    "get_router:ha": "rule:context_is_admin",
    "create_router": "rule:context_is_network_admin",
    "create_router:external_gateway_info:enable_snat": "rule:context_is_admin",
    "create_router:distributed": "rule:context_is_admin",
    "create_router:ha": "rule:context_is_admin",
    "get_router": "rule:context_is_viewer",
    "get_router:distributed": "rule:context_is_admin",
    "update_router": "rule:context_is_network_admin",
    "update_router:external_gateway_info:enable_snat": "rule:context_is_admin",
    "update_router:distributed": "rule:context_is_admin",
    "update_router:ha": "rule:context_is_admin",

    "update_router:cisco_ha:enabled": "rule:context_is_admin",
    "update_router:cisco_ha:details": "rule:context_is_admin",

    "delete_router": "rule:context_is_network_admin",

    "add_router_interface": "rule:context_is_editor",
    "remove_router_interface": "rule:context_is_editor",

    "create_router:external_gateway_info:external_fixed_ips": "rule:context_is_network_admin",
    "update_router:external_gateway_info:external_fixed_ips": "rule:context_is_network_admin",

    "create_security_group": "rule:context_is_compute_admin or rule:context_is_network_admin",
    "get_security_group": "rule:context_is_viewer",
    "get_security_groups": "rule:context_is_viewer",
    "update_security_group": "rule:context_is_compute_admin or rule:context_is_network_admin",
    "delete_security_group": "rule:context_is_compute_admin or rule:context_is_network_admin",

    "create_security_group_rule": "rule:context_is_compute_admin or rule:context_is_network_admin",
    "get_security_group_rule": "rule:context_is_viewer",
    "get_security_group_rules": "rule:context_is_viewer",
    "update_security_group_rule": "rule:context_is_compute_admin or rule:context_is_network_admin",
    "delete_security_group_rule": "rule:context_is_compute_admin or rule:context_is_network_admin",

    "create_firewall": "rule:context_is_admin",
    "get_firewall": "rule:context_is_admin",
    "create_firewall:shared": "rule:context_is_admin",
    "get_firewall:shared": "rule:context_is_admin",
    "update_firewall": "rule:context_is_admin",
    "update_firewall:shared": "rule:context_is_admin",
    "delete_firewall": "rule:context_is_admin",

    "create_firewall_policy": "rule:context_is_admin",
    "get_firewall_policy": "rule:context_is_admin or rule:shared_firewall_policies",
    "create_firewall_policy:shared": "rule:context_is_admin",
    "update_firewall_policy": "rule:context_is_admin",
    "delete_firewall_policy": "rule:context_is_admin",

    "insert_rule": "rule:context_is_admin",
    "remove_rule": "rule:context_is_admin",

    "create_firewall_rule": "rule:context_is_admin",
    "get_firewall_rule": "rule:context_is_admin or rule:shared_firewalls",
    "update_firewall_rule": "rule:context_is_admin",
    "delete_firewall_rule": "rule:context_is_admin",

    "create_qos_queue": "rule:context_is_admin",
    "get_qos_queue": "rule:context_is_admin",

    "update_agent": "rule:context_is_admin",
    "delete_agent": "rule:context_is_admin",
    "get_agent": "rule:context_is_admin",

    "create_dhcp-network": "rule:context_is_admin",
    "delete_dhcp-network": "rule:context_is_admin",
    "get_dhcp-networks": "rule:context_is_admin",
    "create_l3-router": "rule:context_is_admin",
    "delete_l3-router": "rule:context_is_admin",
    "get_l3-routers": "rule:context_is_admin",
    "get_dhcp-agents": "rule:context_is_admin",
    "get_l3-agents": "rule:context_is_admin",
    "get_loadbalancer-agent": "rule:context_is_admin",
    "get_loadbalancer-pools": "rule:context_is_admin",
    "get_agent-loadbalancers": "rule:context_is_admin",
    "get_loadbalancer-hosting-agent": "rule:network_view_all",

    "create_floatingip": "rule:context_is_editor",
    "create_floatingip:floating_ip_address": "rule:context_is_network_admin",
    "update_floatingip": "rule:context_is_editor",
    "delete_floatingip": "rule:context_is_editor",
    "get_floatingip": "rule:context_is_viewer",

    "create_network_profile": "rule:context_is_admin",
    "update_network_profile": "rule:context_is_admin",
    "delete_network_profile": "rule:context_is_admin",
    "get_network_profiles": "rule:context_is_admin",
    "get_network_profile": "rule:context_is_admin",
    "update_policy_profiles": "rule:context_is_admin",
    "get_policy_profiles": "rule:context_is_admin",
    "get_policy_profile": "rule:context_is_admin",

    "create_metering_label": "rule:context_is_admin",
    "delete_metering_label": "rule:context_is_admin",
    "get_metering_label": "rule:context_is_admin",

    "create_metering_label_rule": "rule:context_is_admin",
    "delete_metering_label_rule": "rule:context_is_admin",
    "get_metering_label_rule": "rule:context_is_admin",

    "get_service_provider": "rule:context_is_editor",
    "get_lsn": "rule:context_is_admin",
    "create_lsn": "rule:context_is_admin",

    "create_flavor": "rule:context_is_admin",
    "update_flavor": "rule:context_is_admin",
    "delete_flavor": "rule:context_is_admin",
    "get_flavors": "rule:context_is_admin",
    "get_flavor": "rule:context_is_admin",
    "create_service_profile": "rule:context_is_admin",
    "update_service_profile": "rule:context_is_admin",
    "delete_service_profile": "rule:context_is_admin",
    "get_service_profiles": "rule:context_is_admin",
    "get_service_profile": "rule:context_is_admin",

    "get_policy": "rule:context_is_admin",
    "create_policy": "rule:context_is_admin",
    "update_policy": "rule:context_is_admin",
    "delete_policy": "rule:context_is_admin",
    "get_policy_bandwidth_limit_rule": "rule:context_is_admin",
    "create_policy_bandwidth_limit_rule": "rule:context_is_admin",
    "delete_policy_bandwidth_limit_rule": "rule:context_is_admin",
    "update_policy_bandwidth_limit_rule": "rule:context_is_admin",
    "get_policy_dscp_marking_rule": "rule:context_is_admin",
    "create_policy_dscp_marking_rule": "rule:context_is_admin",
    "delete_policy_dscp_marking_rule": "rule:context_is_admin",
    "update_policy_dscp_marking_rule": "rule:context_is_admin",
    "get_rule_type": "rule:context_is_admin",

    "restrict_wildcard": "(not field:rbac_policy:target_tenant=*) or rule:context_is_admin",
    "create_rbac_policy": "rule:context_is_network_admin",
    "create_rbac_policy:target_tenant": "rule:restrict_wildcard",
    "update_rbac_policy": "rule:context_is_network_admin",
    "update_rbac_policy:target_tenant": "rule:restrict_wildcard and rule:context_is_network_admin",
    "get_rbac_policy": "rule:context_is_viewer",
    "delete_rbac_policy": "rule:context_is_network_admin",

    "create_flavor_service_profile": "rule:context_is_admin",
    "delete_flavor_service_profile": "rule:context_is_admin",
    "get_flavor_service_profile": "rule:context_is_admin",
    "get_auto_allocated_topology": "rule:context_is_admin"
}
