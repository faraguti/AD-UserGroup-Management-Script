<p align="center">
  <img src="https://github.com/faraguti/ps-guessing-game/assets/5418256/f698e140-1d83-46c3-a121-64b8451cc090" height="100%" width="100%">
</p>

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
   
   ```PowerShell
   Create-ManageUsersTestfile.ps1 users.xml
   ```

2. Execute the `AD-UserGroup-Management.ps1` script and provide the filename (including path) of the XML file as input when prompted.
   
   ```PowerShell
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
```
</br>

## Script Functionality

The script performs the following tasks based on the XML file specified by the user:

1. For each user entry in the XML file, the script:
   - Creates the specified organizational unit (OU) if it does not exist.
   - Creates the user account in the OU with attributes from the XML data.
   - Sets the user password using `ConvertTo-SecureString`.
   - Enables the user account and requires a password change on the next login.

2. For each group mentioned in the `<memberOf>` node of the XML file, the script:
   - Creates the group if it does not already exist.
   - Adds the user to the group.

The script provides meaningful output as it executes, informing the user about the actions taken during the user and group management operations.

## Assumptions

Before running the script, the following assumptions are made:

- The computer running the script is part of the domain that needs to be managed.
- The script user has appropriate permissions to perform Active Directory tasks.
- The manager mentioned in the XML data is one of the users listed in the file.

## Notes

- The script is designed to handle errors appropriately using PowerShell's built-in error handling and `Try`-`Catch` blocks.
- The user is guided through the process with input prompts and informative output messages.
- The script allows for the automation of user and group management, saving time and reducing manual errors.

