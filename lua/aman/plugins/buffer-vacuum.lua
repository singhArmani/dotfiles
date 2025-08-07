-- Ref: https://github.com/ChuufMaster/buffer-vacuum
return {
	{
		"ChuufMaster/buffer-vacuum",
		opts = {
			{
				-- The maximum number of buffers to keep (excluding modified buffer)
				max_buffers = 6,

				-- Change to True if you want pinned buffers to count to the
				-- maximum number buffers
				count_pinned_buffers = false,

				-- Enable notifications every time a buffer is pinned or deleted
				-- Default FALSE
				enable_messages = false,
			},
		},
	},
}
