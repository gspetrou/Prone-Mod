import os
import subprocess

gmod_bin_path = "C:/Program Files (x86)/Steam/steamapps/common/GarrysMod/bin"

standalone_folder = "./prone_mod"
standalone_gma = "./prone_mod.gma"
standalone_workshop_id = "1100368137"

wos_folder = "./prone_mod_wos"
wos_gma = "./prone_mod_wos.gma"
wos_workshop_id = "775573383"

def folder_to_gma(folder_name, gma_name):
	gmad = subprocess.run([
		gmod_bin_path + "/gmad.exe",
		"create",
		"-folder", folder_name,
		"-out", gma_name
	])

def update_gma(gma, workshop_id, changes=None):
	change_text = "[h1]Changes[/h1][list]"
	if not changes or len(changes) == 0:
		change_text = "No changes specified."
	else:
		for change in changes:
			change_text += "\n[*] " + change
		change_text += "[/list]"

	gmad = subprocess.run([
		gmod_bin_path + "/gmpublish.exe",
		"update",
		"-addon", gma,
		"-id", workshop_id,
		"-changes", change_text
	])

def gma_and_publish(folder, gma, workshop_id, changes=None, clean_gma=True):
	folder_to_gma(folder, gma)
	print()
	update_gma(gma, workshop_id, changes)

	if clean_gma:
		os.remove(gma)

def update_standalone(changes=None):
	gma_and_publish(standalone_folder, standalone_gma, standalone_workshop_id, changes)

def update_wos(changes=None):
	gma_and_publish(wos_folder, wos_gma, wos_workshop_id, changes)

if __name__ == "__main__":
	# Which addon we updating?
	addon_target_input = input(
		"Which addon would you like to update?\n"
		"\t1\t-\tStandalone\n"
		"\t2\t-\twOS\n"
		"\tBlank\t-\tBoth\n"
	)
	addon_target_input = addon_target_input.strip()
	print()

	# Changes?
	print("Enter change info\n"
		"\tPress <enter> with text add a new change line\n"
		"\tPress <enter> on a blank line to end changelist"
	)
	raw_changes = []
	while True:
		change = input("Change {}: ".format(str(len(raw_changes) + 1)))
		if change == "":
			break

		raw_changes.append(change)

	# Okay, do the thing now
	if addon_target_input == "1":
		update_standalone(raw_changes)
	elif addon_target_input == "2":
		update_wos(raw_changes)
	else:
		update_standalone(raw_changes)
		update_wos(raw_changes)

	print("\nSuccessfully updated addon(s).")