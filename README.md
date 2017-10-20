# Lenovo CNOS Cookbook

## Overview
The cnos cookbook provides a set of recipes and resources for managing Lenovo 
switches. The cookbook provides resources to upload images, upload/download 
configurations and VLAN provisioning. The recipes use the CNOS Ruby APIs 
(Ruby GEM) to communicate with the switch OS and configure them. 

## Recipes
Below is the list of the recipes provided part of the CNOS cookbook.

1. configUpload
This recipe uploads configuration to the switches. 

2. configDownload
This recipe downloads configuration to the switches. The same configuration
can be edited/modified and uploaded back using the configUpload recipe

3. imgUpload
This recipe upload new OS image to the switch.

4. vlan
This recipe manages the VLAN (create/update/delete) provisiong on the switch.

5. vlanIntf
This recipe provides the management of VLAN properties for ethernet and 
port-channel interfaces.

6. ipIntf
This recipe provides the management of IP interfaces.


## Dependencies
  * Chef 13 or later
  * Lenovo CNOS 10.4 or later

## Running the cookbook
1. Install chef-client on the node
2. Install Lenovo CNOS Ruby GEM in the same node(or include in default recipe).
3. Create switch.yml for each Lenovo device to be configured using the work 
   station, see below example file
```
transport : 'http' #http or https
port : '8090' #8090 or 443
ip : 'switch ip address' #Switch IP address
user : '<user>' #Credentials
password : '<password>' #Credentials
```
4. Add required recipe to node run-list 
5. Run chef-client on node
6. Upload to the run-list of the chef-server and configure the devices


## Contributors
  * Lenovo DCG Networking, Lenovo 

## License
Apache 2.0, See LICENSE file
