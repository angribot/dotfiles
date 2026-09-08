# Static completions: never contact Surge or prompt for credentials on Tab.
function __fish_surge_cli_args
    set -l tokens (commandline -opc)
    set -e tokens[1]
    set -l skip_next 0
    for token in $tokens
        if test $skip_next -eq 1
            set skip_next 0
            continue
        end
        switch $token
            case --remote -r --check -c
                set skip_next 1
            case '--remote=*' '--check=*' --raw --password-stdin --help -h
            case '*'
                printf '%s\n' "$token"
        end
    end
end

# Match an exact positional command path; `help` shares the command tree.
function __fish_surge_cli_at
    set -l args (__fish_surge_cli_args)
    if test "$args[1]" = help
        set -e args[1]
    end
    test (count $args) -eq (count $argv); or return 1
    test (count $argv) -eq 0; and return 0
    for i in (seq (count $argv))
        test "$args[$i]" = "$argv[$i]"; or return 1
    end
    return 0
end

complete -c surge-cli -f
complete -c surge-cli -s h -l help -d 'Show help'
complete -c surge-cli -l raw -d 'Output raw JSON; skip command validation'
complete -c surge-cli -s r -l remote -x -d 'Remote host:port (IPv6: [address]:port)'
complete -c surge-cli -l password-stdin -d 'Read remote password from stdin'
complete -c surge-cli -s c -l check -r -F -d 'Validate a profile file offline'

for entry in \
    'help:Show command usage' \
    'status:Show current Surge status' \
    'summary:Show network summary' \
    'version:Show app and protocol versions' \
    'mode:Get or set outbound mode' \
    'global-policy:Get or set global proxy policy' \
    'policy-group:Inspect or select policy groups' \
    'rule:Evaluate routing or manage temporary rules' \
    'profile:Inspect or switch profiles' \
    'module:List or toggle modules' \
    'feature:Inspect or toggle runtime features' \
    'managed-profile:Update managed profile' \
    'external-resource:List or update external resources' \
    'plugin:Manage plugins and offline packages' \
    'dns:Resolve domains or trace DNS' \
    'geoip:Look up GeoIP and ASN' \
    'http:Probe an HTTP endpoint' \
    'test:Run network diagnostics' \
    'diagnostics:Stream diagnostics' \
    'stop-diagnostics:Stop diagnostics' \
    'flush:Flush cached data' \
    'dump:Inspect runtime data' \
    'watch:Watch requests or throughput' \
    'log:Read or follow logs' \
    'logbook:Show recent logbook records' \
    'proxy-runtime-status:Inspect proxy runtime by line hash' \
    'script:List or run scripts' \
    'script-log:Show script execution log' \
    'benchmark:Benchmark encryption or rule matching' \
    'device:Inspect gateway devices' \
    'vmnet:Inspect virtual network interface' \
    'security:Manage unauthorized-access bans' \
    'reload:Reload changed profile sections' \
    'restart-engine:Restart engine and close connections' \
    'switch-profile:Switch active profile' \
    'kill:Terminate a connection' \
    'stop:Stop Surge' \
    'unattended-upgrade:Upgrade Surge unattended' \
    'environment:Show environment settings' \
    'set:Update environment key=value pairs' \
    'set-log-level:Set runtime log level' \
    'test-group:Retest a policy group' \
    'test-all-policies:Retest all policies' \
    'test-policy:Test policies' \
    'test-policy-udp:Test policy UDP support' \
    'test-policy-external-ip:Probe external IP via a policy' \
    'test-policy-nat-type:Probe NAT type via a policy' \
    'test-policy-bandwidth:Measure policy bandwidth' \
    'test-network:Test network delay' \
    'test-ponte:Run Ponte diagnostics' \
    'show-policy:Show policy details' \
    'retrieve-data:Fetch captured request or response body' \
    'get-resource:Fetch device icons' \
    'set-dhcp-device:Set DHCP device parameters' \
    'remove-device-record:Remove device records' \
    'update-profile:Update base64-encoded Rule section' \
    'add-temp-rule:Add a temporary rule' \
    'del-temp-rule:Delete a temporary rule' \
    'update-temp-rule:Change a temporary rule policy' \
    'flush-temp-rule:Clear temporary rules' \
    'reconnect-device:Reconnect an AP client'
    set -l parts (string split -m 1 : -- $entry)
    complete -c surge-cli -n __fish_surge_cli_at -a $parts[1] -d $parts[2]
end

# Each row is a command path followed by its fixed choices.
for row in \
    'mode|get set' \
    'mode set|rule direct proxy' \
    'global-policy|get set' \
    'policy-group|list get set' \
    'rule|match explain temp' \
    'rule temp|list add remove set-policy flush' \
    'profile|list current diff check switch' \
    'module|list enable disable' \
    'feature|list get set' \
    'feature get|mitm rewrite scripting capture packet-capture cellular-mode system-proxy enhanced-mode' \
    'feature set|mitm rewrite scripting capture packet-capture cellular-mode system-proxy enhanced-mode' \
    'managed-profile|update' \
    'external-resource|list update' \
    'external-resource update|all' \
    'plugin|list info parameters install load-unpacked configure enable disable select uninstall validate pack' \
    'plugin select|ap-controller' \
    'plugin select ap-controller|none' \
    'dns|lookup trace' \
    'http|probe' \
    'test|v4-router dns encrypted-dns external-ip nat-type' \
    'flush|dns' \
    'dump|active recent request dns traffic auto-test-group-result policy rule map-remote map-local profile event policy-group-sub-policies traffic-stat traffic-stat-host temp-rule summary virtual-ip-db virtual-ip smart-group-info performance rule-usage' \
    'dump profile|original effective' \
    'dump traffic-stat|prefix' \
    'watch|request speed' \
    'log|file memory watch' \
    'script|list run evaluate' \
    'benchmark|encryption rule-matching' \
    'device|list show' \
    'vmnet|status arp ndp ra' \
    'security|ban' \
    'security ban|list clear' \
    'test-policy-bandwidth|download upload' \
    'get-resource|device-icon'
    set -l parts (string split '|' -- $row)
    complete -c surge-cli -n "__fish_surge_cli_at $parts[1]" -a "$parts[2]"
end

for feature in mitm rewrite scripting capture packet-capture cellular-mode system-proxy enhanced-mode
    complete -c surge-cli -n "__fish_surge_cli_at feature set $feature" -a 'on off'
end

# Arbitrary names/URLs are left to the user; only actual filesystem args
# enable file completion. Profile names refer to Surge's profile store.
complete -c surge-cli -n '__fish_surge_cli_at script evaluate' -F
for subcommand in load-unpacked validate pack
    complete -c surge-cli -n "__fish_surge_cli_at plugin $subcommand" -a '(__fish_complete_directories)'
end

function __fish_surge_cli_after_target
    set -l args (__fish_surge_cli_args)
    test (count $args) -ge 3; or return 1
    test "$args[1]" = "$argv[1]"; or return 1
    contains -- "$args[2]" $argv[2..-1]
end

complete -c surge-cli -n '__fish_surge_cli_after_target rule match explain' -a 'hostname= dest-port= port= process-path= user-agent= url= sni= http-host= source-address= source-port= is-local=on is-local=off client-mac= listen-port= protocol=TCP protocol=UDP protocol=HTTP protocol=HTTPS protocol=QUIC protocol=STUN device-name='
complete -c surge-cli -n '__fish_surge_cli_after_target dns lookup trace' -a 'interface='
complete -c surge-cli -n '__fish_surge_cli_after_target policy-group set' -a auto -d 'Clear automatic-group override'
