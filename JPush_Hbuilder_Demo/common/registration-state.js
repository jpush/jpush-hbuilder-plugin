let latestRegistrationID = ''

export function updateRegistrationID(registrationID) {
	if (typeof registrationID !== 'string' || !registrationID) return
	latestRegistrationID = registrationID
	uni.$emit('registrationIDChange', registrationID)
}

export function getCachedRegistrationID() {
	return latestRegistrationID
}
