// Only actual native connection events update this in-memory state.
let latestConnectionState = null

export function updateConnectionState(connected) {
	if (typeof connected !== 'boolean') return
	latestConnectionState = connected
	uni.$emit('connectStatusChange', connected)
}

export function getConnectionState() {
	return latestConnectionState
}
