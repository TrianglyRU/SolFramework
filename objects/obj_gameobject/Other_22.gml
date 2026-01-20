/// @description Path Step
/// Called in obj_game -> End Step

// Use this Event instead of the Step Event if your object moves along a path
// 
// This is necessary because when using a path, the object's X and Y positions
// are updated after the Step Event, which can cause Orbinaut's collision functions
// to work incorrectly