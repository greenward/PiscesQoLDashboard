<?php
$info['last_challenge'] = shell_exec("grep 'submitting blockchain_txn_poc_receipts_' /home/pi/hnt/miner/log/console.log | awk '{print $1, $2}' | sort -nr | head -1");
$info['last_beacon'] = shell_exec("grep 'miner_lora:send_packet' /home/pi/hnt/miner/log/console.log | grep 'PULL_RESP' | awk '{print $1,$2}' | sort -nr | head -1");
$info['last_witness'] = shell_exec("grep 'client sending data' /home/pi/hnt/miner/log/console.log | awk '{ print $1,$2}' | sort -nr | head -1");
?>
<h1>Pisces P100 Outdoor Miner Dashboard - Diagnostics</h1>

<ul>
<li>Last Challenge - <?php echo $info['last_challenge']; ?></li>
<li>Last Beacon - <?php echo $info['last_beacon']; ?></li>
<li>Last Witness - <?php echo $info['last_witness']; ?></li>
</ul>