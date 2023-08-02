# Active Directory User & Group Management Script

## Overview

The **Active Directory User & Group Management Script** is a PowerShell script designed to automate user and group management tasks within an Active Directory domain. The script reads user information from an XML file and performs the following functions:

1. **Create Users:** The script creates user accounts in the specified organizational unit (OU) or creates a new OU if it does not exist. User attributes such as account name, first name, last name, description, password, and manager are set based on the data from the XML file. The created accounts are enabled, and users are required to change their passwords on their next login.

2. **Create Groups:** The script creates domain global security groups listed in the `<memberOf>` node of the XML file if they do not already exist.

3. **Add Users to Groups:** The script adds users to the domain global security groups specified in the `<memberOf>` node.

## Requirements

- PowerShell version with the Active Directory module installed.
- The user running the script should have sufficient rights to perform all the required tasks in Active Directory.

## Usage

1. Run the `Create-ManageUsersTestfile.ps1` script to create a test XML file with user data (e.g., users.xml).
   
   ```
   Create-ManageUsersTestfile.ps1 users.xml
   ```

2. Execute the `AD-UserGroup-Management.ps1` script and provide the filename (including path) of the XML file as input when prompted.
   
   ```
   ./Manage-Users.ps1
   ```
   `Please enter file path: C:\Path\To\users.xml`
</br>

## XML Data Format (Sample users.xml)

```xml
<root>
	<user>
		<account>Chico</account>
		<firstname>Leonard</firstname>
		<lastname>Marx</lastname>
		<description>Pianist</description>
		<password>Password1</password>
		<manager></manager>
		<ou>comedians</ou>
		<memberOf>
			<group>Marx Brothers</group>
			<group>GGMusicians</group>
		</memberOf>
	</user>
</root>

