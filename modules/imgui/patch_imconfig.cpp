#include "imconfig.h"

namespace mu
{
	namespace details
	{
		thread_local ImGuiContext* g_ImGuiContext { nullptr };
	}
}
