/*  Create a dictionary to store all user selected radio buttons (options) and checkboxes (items).  The checkbox categories
	(meat and veggie) require arrays to hold a variable number of items chosen.
*/
var menu_selections = {
	size: "Personal Pizza",
	crust: "Plain Crust",
	sauce: "Marinara Sauce",
	cheese: "Regular Cheese",
	meat: [],
	veggie: []
};
//  Create an array of dictionaries to store the price information for each option.
var option_cost = [
	{
	'Personal Pizza': 6,
	'Medium Pizza': 10,
	'Large Pizza': 14,
	'Extra Large Pizza': 16
	},
	{'Plain Crust': 0, 'Garlic Butter Crust': 0, 'Cheese Stuffed Crust': 3, 'Spicy Crust': 0, 'House Special Crust': 0},
	{'Marinara Sauce': 0, 'White Sauce': 0, 'Barbecue Sauce': 0, 'No Sauce': 0},
	{'Regular Cheese': 0, 'No Cheese': 0, 'Extra Cheese': 3}
]
// Create an array to store names of all options and items categories.
var categories = ['size', 'crust', 'sauce', 'cheese', 'meat', 'veggie'];
//  userSelect is called each time a radio button or checkbox changes state (is clicked).
function userSelect(item, item_class) {
/*  If any checkbox is changed (meats or veggies), test to see if the item was previously selected and stored in menu_selections dictionary.
	If the item has already been selected, then remove it (with splice), otherwise add it (with push).
*/
	if (item_class === 'meat' || item_class === 'veggie') {
		if (menu_selections[item_class].includes(item)) {
			var n = menu_selections[item_class].indexOf(item);
			menu_selections[item_class].splice(n,1);
		} else {
			menu_selections[item_class].push(item);
		}
//	For radio buttons (options) simply overwrite the stored value with the current user selection.
	} else {
		menu_selections[item_class] = item;
	}
}
/*	printReceipt is called when user selects the "Confirm Order" button and prints a tabulated list of all options and items selected
	along with each subtotal cost and final total price at bottom of receipt.
*/
function printReceipt() {
/*	Use jQuery empty() to remove all child elements that may be present from the result of a previous press of "Confirm Order" button to prevent
	multiple receipts from being displayed.  Clearing just the receipt first (leaving all radio buttons and checkboxes unchanged) allows the user
	to make small changes to selections and confirm again to rapidly get an updated receipt.
*/
		$("#receipt_form").empty();
		var total_cost = 0;
		add_HTML("You Ordered:", "Subtotal", "th");
/*	Cycle through all option & item categories.  For items (meats/veggies), additionally cycle through all checkboxes and assign cost of $1 to
	each item beyond the first in each category, while maintaining a running total cost.
*/
		for (var i = 0; i < 6; i++) {
			item_label = menu_selections[categories[i]];
			if (categories[i] === 'meat' || categories[i] === 'veggie') {
				var sub_cost = 0;
				for (var j = 0; j < item_label.length; j++) {
					sub_cost = (j > 0 ? 1 : 0).toFixed(2);
					add_HTML(item_label[j], "+$" + sub_cost, "td");
//	Use of toFixed() converts sub_cost into a string.  Use parseFloat to convert back to number to allow adding to total_cost.
					total_cost = total_cost + parseFloat(sub_cost);
				}
			} else {
//	Costs of options are simply retrieved from the option_cost dictionary.
				sub_cost = option_cost[i][item_label].toFixed(2);
				add_HTML(item_label, "+$" + sub_cost, "td");
				total_cost = total_cost + parseFloat(sub_cost);
			}
		}
		add_HTML("Total Price:", "$" + total_cost.toFixed(2), "th");
}
//  Create elements as needed (table rows, headers, cells) and append them to the table with id="receipt_form" to build the receipt. 
function add_HTML(col_1, col_2, element_type) {
	var row = document.createElement("tr");
	var element = document.getElementById("receipt_form");
	element.appendChild(row);
	var cell = document.createElement(element_type);
	var node = document.createTextNode(col_1);
	cell.appendChild(node);
	element.appendChild(cell);
	var cell2 = document.createElement(element_type);
	var node2 = document.createTextNode(col_2);
	cell2.appendChild(node2);
	element.appendChild(cell2);
}
//	Clears the printed receipt when user selects "Cancel" button and also resets all radio buttons and checkboxes with reload.
function clearReceipt() {
	location.reload(false);
}