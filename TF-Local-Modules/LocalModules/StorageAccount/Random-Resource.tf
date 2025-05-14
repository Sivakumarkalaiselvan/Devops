# Random String Resource
resource "random_string" "my_random"{
    length = 5
    upper = false
    numeric = false
    special = false
}