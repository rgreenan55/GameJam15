class_name WizardCraftingState extends State;

func Enter() -> void:
	super();
	parent.get_node("PotionHandler").visible = false;

func Exit() -> void:
	parent.get_node("PotionHandler").visible = true;
