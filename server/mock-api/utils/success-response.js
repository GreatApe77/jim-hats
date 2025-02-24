// Helper function for success responses
export const successResponse = (message, data = null) => {
    return {
      status: "success",
      message: message,
      data: data
    };
  };