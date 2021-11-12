<?php
$load = sys_getloadavg();
$diskfree = disk_free_space(".") / 1073741824;
$disktotal = disk_total_space(".") / 1073741824;
$diskused = $disktotal - $diskfree;
$diskusage = round($diskused/$disktotal*100);
$stats = @file_get_contents("/proc/meminfo");

$stats = str_replace(array("\r\n", "\n\r", "\r"), "\n", $stats);
$stats = explode("\n", $stats);

$tmpMemTotal = explode(":", $stats[0]);
$tmpMemTotal = trim(str_replace('kB', '', $tmpMemTotal[1]));

$tmpMemFree = explode(":", $stats[2]);
$tmpMemFree = trim(str_replace('kB', '', $tmpMemFree[1]));

$tmpMemUsed = $tmpMemTotal - $tmpMemFree;

$info['MemTotal'] = round(($tmpMemTotal / 1024) / 1024, 1)."GB";
$info['MemUsed'] = round(($tmpMemUsed / 1024) / 1024, 1)."GB";
$info['MemUsage'] = round(($tmpMemUsed / $tmpMemTotal) * 100, 2)."%";

$raw = array("eth0", "wlan0");
$pretty = array("LAN", "WLAN");

$info['IP'] = str_replace($raw, $pretty, trim(file_get_contents("/var/dashboard/statuses/local-ip")));
$info['ExternalIP'] = trim(file_get_contents("/var/dashboard/statuses/external-ip"));
$info['CPU'] = trim(file_get_contents("/var/dashboard/statuses/cpu"));
$info['DiskUsage'] = round($diskused/$disktotal*100, 2)."%";

$gps = trim(file_get_contents("/var/dashboard/statuses/gps"));
$pf = trim(file_get_contents("/var/dashboard/statuses/packet-forwarder"));
$info['BT'] = trim(ucfirst(file_get_contents("/var/dashboard/statuses/bt")));
$info['Miner'] = trim(file_get_contents("/var/dashboard/statuses/miner"));
$info['Temp'] = trim(file_get_contents("/var/dashboard/statuses/temp"));
$info['WiFi'] = trim(file_get_contents("/var/dashboard/statuses/wifi"));
$info['CurrentVersion'] = trim(file_get_contents("/var/dashboard/statuses/current_miner_version"));
$info['PiscesVersion'] = shell_exec("cat /home/pi/api/tool/version | grep \"version\" | sed 's/\"version\"://' | xargs");
if($gps == 1)
{
$info['GPS'] = 'Enabled';
}
else
{
$info['GPS'] = 'Disabled';
}

if($pf > 0)
{
	$info['PF'] = $pf;
}
else
{
	$info['PF'] = 'Disabled';
}
?>
<h1>Pisces P100 Outdoor Miner Dashboard</h1>

<div id="miner_info">
<h2>Miner Information</h2>
<ul>
<li>Firmware Version: <?php echo $info['CurrentVersion']; ?></li>
<li>Pisces Version: <?php echo $info['PiscesVersion']; ?></li>
<li>IP: <?php echo $info['IP'].' / '.$info['ExternalIP']; ?></li>
<li>CPU: <?php echo $info['CPU']; ?>%</li>
<li>Mem: <?php echo $info['MemUsed']." / ".$info['MemTotal']." - ".$info['MemUsage']; ?></li>
<li>Disk: <?php echo $info['DiskUsage']; ?></li>
<li>Temp: <?php echo $info['Temp']; ?></li>
</ul>
</div>

<div id="toggle_buttons">
<h2>Enable/disable Services</h2>
<ul>
<?php
if($info['GPS'] == 'Enabled')
{
echo '<li id="GPS_status" class="enabled">';
echo '<a href="#" onclick="DisableService(\'GPS\');" title="GPS enabled">';
echo '<span class="icon-gps_fixed"></span>';
echo '</a>';
echo '</li>';
}
else
{
echo '<li id="GPS_status" class="disabled">';
echo '<a href="#" onclick="EnableService(\'GPS\');" title="GPS disabled">';
echo '<span class="icon-gps_off"></span>';
echo '</a>';
echo '</li>';

}
if($info['BT'] == 'On')
{
echo '<li id="BT_status" class="enabled">';
echo '<a href="#" onclick="DisableService(\'BT\');" title="Bluetooth advertise enabled">';
echo '<span class="icon-bluetooth"></span>';
echo '</a>';
echo '</li>';
}
else
{
echo '<li id="BT_status" class="disabled">';
echo '<a href="#" onclick="EnableService(\'BT\');" title="BlueTooth advertise disabled">';
echo '<span class="icon-bluetooth_disabled"></span>';
echo '</a>';
echo '</li>';

}

if($info['PF'] != 'Disabled')
{
echo '<li id="PF_status" class="enabled">';
echo '<a href="#" onclick="DisableService(\'PF\');" title="Packet forwarder enabled: '.$info['PF'].'">';
echo '<span class="icon-play_arrow"></span>';
echo '</a>';
echo '</li>';
}
else
{
echo '<li id="PF_status" class="disabled">';
echo '<a href="#" onclick="EnableService(\'PF\');" title="Packet forwarder disabled">';
echo '<span class="icon-play_disabled"></span>';
echo '</a>';
echo '</li>';

}

if($info['Miner'] == 'true')
{
echo '<li id="Miner_status" class="enabled">';
echo '<a href="#" onclick="DisableService(\'miner\');" title="Miner enabled">';
echo '<span class="icon-zap"></span>';
echo '</a>';
echo '</li>';
}
else
{
echo '<li id="Miner_status" class="disabled">';
echo '<a href="#" onclick="EnableService(\'miner\');" title="Miner disabled">';
echo '<span class="icon-zap-off"></span>';
echo '</a>';
echo '</li>';

}

if($info['WiFi'] != '')
{
echo '<li id="WiFi_status" class="enabled">';
echo '<a href="#" onclick="DisableService(\'WiFi\');" title="WiFi enabled">';
echo '<span class="icon-wifi"></span>';
echo '</a>';
echo '</li>';
}
else
{
echo '<li id="WiFi_status" class="disabled">';
echo '<a href="#" onclick="EnableService(\'WiFi\');" title="WiFi disabled">';
echo '<span class="icon-wifi-off"></span>';
echo '</a>';
echo '</li>';

}
?>
</ul>
</div>
