# Random String Resource
resource "random_string" "my_random"{
    length = 4
    upper = false
    numeric = false
    special = false
}